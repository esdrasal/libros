<?php
// Script para ejecutar migraciones en InfinityFree
// Ejecutar una sola vez visitando: tudominio.com/migrate.php

// Cargar variables de entorno
if (file_exists(__DIR__ . '/.env')) {
    $envFile = file(__DIR__ . '/.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($envFile as $line) {
        if (strpos(trim($line), '#') === 0) continue;
        list($name, $value) = explode('=', $line, 2);
        putenv(trim($name) . '=' . trim($value));
    }
}

// Configuración de la base de datos
$host = getenv('PRODUCTION_DB_HOST') ?: getenv('DB_HOST');
$username = getenv('PRODUCTION_DB_USERNAME') ?: getenv('DB_USERNAME');
$password = getenv('PRODUCTION_DB_PASSWORD') ?: getenv('DB_PASSWORD');
$database = getenv('PRODUCTION_DB_NAME') ?: getenv('DB_NAME');

try {
    $pdo = new PDO("mysql:host=$host;dbname=$database;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "<h1>Ejecutando Migraciones</h1>";
    
    // Crear tabla de migraciones si no existe
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS schema_migrations (
            version varchar(255) NOT NULL PRIMARY KEY
        )
    ");
    
    // Ejecutar cada migración
    $migrations = [
        '20250814234153' => "
            CREATE TABLE IF NOT EXISTS libros (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                titulo varchar(255),
                autor varchar(255),
                paginas_total int,
                created_at datetime(6) NOT NULL,
                updated_at datetime(6) NOT NULL
            )
        ",
        '20250815000153' => "
            CREATE TABLE IF NOT EXISTS active_storage_blobs (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                `key` varchar(255) NOT NULL,
                filename varchar(255) NOT NULL,
                content_type varchar(255),
                metadata longtext,
                service_name varchar(255) NOT NULL,
                byte_size bigint NOT NULL,
                checksum varchar(255),
                created_at datetime(6) NOT NULL,
                INDEX index_active_storage_blobs_on_key (`key`)
            );
            CREATE TABLE IF NOT EXISTS active_storage_attachments (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                name varchar(255) NOT NULL,
                record_type varchar(255) NOT NULL,
                record_id bigint NOT NULL,
                blob_id bigint NOT NULL,
                created_at datetime(6) NOT NULL,
                INDEX index_active_storage_attachments_on_blob_id (blob_id),
                INDEX index_active_storage_attachments_uniqueness (name, record_type, record_id, blob_id)
            );
            CREATE TABLE IF NOT EXISTS active_storage_variant_records (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                blob_id bigint NOT NULL,
                variation_digest varchar(255) NOT NULL,
                INDEX index_active_storage_variant_records_uniqueness (blob_id, variation_digest)
            )
        ",
        '20250815010449' => "
            CREATE TABLE IF NOT EXISTS nota (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                titulo varchar(255),
                contenido text,
                libro_id bigint,
                pagina int,
                created_at datetime(6) NOT NULL,
                updated_at datetime(6) NOT NULL,
                INDEX index_nota_on_libro_id (libro_id)
            )
        ",
        '20250815025015' => "
            CREATE TABLE IF NOT EXISTS users (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                email varchar(255) DEFAULT '' NOT NULL,
                encrypted_password varchar(255) DEFAULT '' NOT NULL,
                reset_password_token varchar(255),
                reset_password_sent_at datetime(6),
                remember_created_at datetime(6),
                created_at datetime(6) NOT NULL,
                updated_at datetime(6) NOT NULL,
                UNIQUE INDEX index_users_on_email (email),
                UNIQUE INDEX index_users_on_reset_password_token (reset_password_token)
            )
        ",
        '20250815025534' => "
            CREATE TABLE IF NOT EXISTS user_libros (
                id bigint AUTO_INCREMENT PRIMARY KEY,
                user_id bigint NOT NULL,
                libro_id bigint NOT NULL,
                created_at datetime(6) NOT NULL,
                updated_at datetime(6) NOT NULL,
                INDEX index_user_libros_on_user_id (user_id),
                INDEX index_user_libros_on_libro_id (libro_id)
            )
        ",
        '20250815030600' => "
            ALTER TABLE user_libros ADD COLUMN progress int DEFAULT 0
        ",
        '20250815030709' => "
            ALTER TABLE nota ADD COLUMN user_id bigint,
            ADD INDEX index_nota_on_user_id (user_id)
        "
    ];
    
    foreach ($migrations as $version => $sql) {
        // Verificar si ya se ejecutó
        $stmt = $pdo->prepare("SELECT version FROM schema_migrations WHERE version = ?");
        $stmt->execute([$version]);
        
        if ($stmt->rowCount() == 0) {
            echo "<p>Ejecutando migración: $version</p>";
            $pdo->exec($sql);
            $pdo->prepare("INSERT INTO schema_migrations (version) VALUES (?)")->execute([$version]);
            echo "<p style='color: green;'>✅ Migración $version completada</p>";
        } else {
            echo "<p style='color: blue;'>⏭️ Migración $version ya ejecutada</p>";
        }
    }
    
    echo "<h2 style='color: green;'>¡Migraciones completadas!</h2>";
    echo "<p><strong>IMPORTANTE:</strong> Borra este archivo migrate.php después de ejecutarlo por seguridad.</p>";
    
} catch (Exception $e) {
    echo "<h2 style='color: red;'>Error:</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
}
?>