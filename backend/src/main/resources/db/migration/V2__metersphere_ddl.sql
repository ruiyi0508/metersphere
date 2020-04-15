CREATE TABLE IF NOT EXISTS `file_content` (
    `file_id` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT 'File ID',
    `file`    longblob COMMENT 'File content',
    PRIMARY KEY (`file_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `file_metadata` (
    `id`          varchar(64) NOT NULL COMMENT 'File ID',
    `name`        varchar(64) NOT NULL COMMENT 'File name',
    `type`        varchar(64) DEFAULT NULL COMMENT 'File type',
    `size`        bigint(13)  NOT NULL COMMENT 'File size',
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `load_test` (
    `id`                     varchar(50) NOT NULL COMMENT 'Test ID',
    `project_id`             varchar(50) NOT NULL COMMENT 'Project ID this test belongs to',
    `name`                   varchar(64) NOT NULL COMMENT 'Test name',
    `description`            varchar(255) DEFAULT NULL COMMENT 'Test description',
    `scenario_definition`    varchar(255) DEFAULT NULL COMMENT 'Scenario definition (JSON format)',
    `load_configuration`     longtext COMMENT 'Load configuration (JSON format)',
    `advanced_configuration` longtext COMMENT 'Load configuration (JSON format)',
    `schedule`               longtext COMMENT 'Test schedule (cron list)',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp',
    `status`                 varchar(64)  DEFAULT NULL COMMENT 'Test Status Running, Completed, Error, etc.',
    `test_resource_pool_id` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `load_test_file` (
    `test_id` varchar(64) DEFAULT NULL,
    `file_id` varchar(64) DEFAULT NULL,
    UNIQUE KEY `load_test_file_unique_key` (`test_id`, `file_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='测试和文件的关联表';

CREATE TABLE IF NOT EXISTS `load_test_report` (
    `id`          varchar(50) NOT NULL COMMENT 'Test report ID',
    `test_id`     varchar(50) NOT NULL COMMENT 'Test ID this test report belongs to',
    `name`        varchar(64) NOT NULL COMMENT 'Test report name',
    `description` varchar(255) DEFAULT NULL COMMENT 'Test report name',
    `content`     longtext,
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    `status`      varchar(64) NOT NULL COMMENT 'Status of this test run',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `load_test_report_detail` (
  `report_id` varchar(50) NOT NULL,
  `content` longtext,
  PRIMARY KEY (`report_id`)
)
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8mb4
    COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `organization` (
    `id`          varchar(50) NOT NULL COMMENT 'Organization ID',
    `name`        varchar(64) NOT NULL COMMENT 'Organization name',
    `description` varchar(255) DEFAULT NULL COMMENT 'Organization description',
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `project` (
    `id`           varchar(50) NOT NULL COMMENT 'Project ID',
    `workspace_id` varchar(50) NOT NULL COMMENT 'Workspace ID this project belongs to',
    `name`         varchar(64) NOT NULL COMMENT 'Project name',
    `description`  varchar(255) DEFAULT NULL COMMENT 'Project description',
    `create_time`  bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`  bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `role` (
    `id`          varchar(50) NOT NULL COMMENT 'Role ID',
    `name`        varchar(64) NOT NULL COMMENT 'Role name',
    `description` varchar(255) DEFAULT NULL COMMENT 'Role description',
    `type`        varchar(50)  DEFAULT NULL COMMENT 'Role type, (system|organization|workspace)',
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `system_parameter` (
    `param_key`   varchar(64) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Parameter name',
    `param_value` varchar(255)                               DEFAULT NULL COMMENT 'Parameter value',
    `type`        varchar(100)                      NOT NULL DEFAULT 'text' COMMENT 'Parameter type',
    `sort`        int(5)                                     DEFAULT NULL COMMENT 'Sort',
    PRIMARY KEY (`param_key`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `test_resource` (
    `id`                    varchar(50) NOT NULL COMMENT 'Test resource ID',
    `test_resource_pool_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT 'Test resource pool ID this test resource belongs to',
    `configuration`         longtext COMMENT 'Test resource configuration',
    `status`                varchar(64) NOT NULL COMMENT 'Test resource status',
    `create_time`           bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`           bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `test_resource_pool` (
    `id`          varchar(50) NOT NULL COMMENT 'Test resource pool ID',
    `name`        varchar(64) NOT NULL COMMENT 'Test resource pool name',
    `type`        varchar(30) NOT NULL COMMENT 'Test resource pool type',
    `description` varchar(255) DEFAULT NULL COMMENT 'Test resource pool description',
    `status`      varchar(64) NOT NULL COMMENT 'Test resource pool status',
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `user` (
    `id`                   varchar(50) NOT NULL COMMENT 'User ID',
    `name`                 varchar(64) NOT NULL COMMENT 'User name',
    `email`                varchar(64) NOT NULL COMMENT 'E-Mail address',
    `password`             varchar(256) DEFAULT NULL,
    `status`               varchar(50) NOT NULL COMMENT 'User status',
    `create_time`          bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`          bigint(13)  NOT NULL COMMENT 'Update timestamp',
    `language`             varchar(30)  DEFAULT NULL,
    `last_workspace_id`    varchar(50)  DEFAULT NULL,
    `last_organization_id` varchar(50)  DEFAULT NULL,
    `phone`                varchar(50)  DEFAULT NULL COMMENT 'Phone number of user',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `user_role` (
    `id`          varchar(50) NOT NULL COMMENT 'ID of user''s role info',
    `user_id`     varchar(50) NOT NULL COMMENT 'User ID of this user-role info',
    `role_id`     varchar(50) NOT NULL COMMENT 'Role ID of this user-role info',
    `source_id`   varchar(50) DEFAULT NULL COMMENT 'The (system|organization|workspace) ID of this user-role info',
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `workspace` (
    `id`              varchar(50) NOT NULL COMMENT 'Workspace ID ',
    `organization_id` varchar(50) NOT NULL COMMENT 'Organization ID this workspace belongs to',
    `name`            varchar(64) NOT NULL COMMENT 'Workspace name',
    `description`     varchar(255) DEFAULT NULL COMMENT 'Workspace description',
    `create_time`     bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`     bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

-- api start

CREATE TABLE IF NOT EXISTS `api_test` (
    `id`                     varchar(50) NOT NULL COMMENT 'Test ID',
    `project_id`             varchar(50) NOT NULL COMMENT 'Project ID this test belongs to',
    `name`                   varchar(64) NOT NULL COMMENT 'Test name',
    `description`            varchar(255) DEFAULT NULL COMMENT 'Test description',
    `runtime_configuration`     longtext COMMENT 'Load configuration (JSON format)',
    `schedule`               longtext COMMENT 'Test schedule (cron list)',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `api_test_file` (
    `test_id` varchar(64) DEFAULT NULL,
    `file_id` varchar(64) DEFAULT NULL,
    UNIQUE KEY `api_test_file_unique_key` (`test_id`, `file_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4 COMMENT ='Api test test file relevance table';

CREATE TABLE IF NOT EXISTS `api_test_report` (
    `id`          varchar(50) NOT NULL COMMENT 'Test report ID',
    `test_id`     varchar(50) NOT NULL COMMENT 'Test ID this test report belongs to',
    `name`        varchar(64) NOT NULL COMMENT 'Test report name',
    `description` varchar(255) DEFAULT NULL COMMENT 'Test report name',
    `content`     longtext,
    `create_time` bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time` bigint(13)  NOT NULL COMMENT 'Update timestamp',
    `status`      varchar(64) NOT NULL COMMENT 'Status of this test run',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

-- api end

-- track start

CREATE TABLE IF NOT EXISTS `test_plan` (
    `id`                     varchar(50) NOT NULL COMMENT 'Test Plan ID',
    `project_id`             varchar(50) NOT NULL COMMENT 'Project ID this plan belongs to',
    `workspace_id`           varchar(50) NOT NULL COMMENT 'Workspace ID this plan belongs to',
    `name`                   varchar(64) NOT NULL COMMENT 'Plan name',
    `description`            varchar(255) DEFAULT NULL COMMENT 'Plan description',
    `status`                 varchar(20) NOT NULL COMMENT 'Plan status',
    `stage`                  varchar(30) NOT NULL COMMENT 'Plan stage',
    `principal`              varchar(50) NOT NULL COMMENT 'Plan principal',
    `test_case_match_rule`   varchar(255) DEFAULT NULL COMMENT 'Test case match rule',
    `executor_match_rule`    varchar(255) DEFAULT NULL  COMMENT 'Executor match rule)',
    `tags`                   text COMMENT 'Test plan tags (JSON format)',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;


CREATE TABLE IF NOT EXISTS `test_case_node` (
    `id`                     int(13) PRIMARY KEY AUTO_INCREMENT COMMENT 'Test case node ID',
    `project_id`             varchar(50) NOT NULL COMMENT 'Project ID this node belongs to',
    `name`                   varchar(64) NOT NULL COMMENT 'Node name',
    `p_id`                   int(13) DEFAULT NULL COMMENT 'Parent node ID',
    `level`                  int(10)  DEFAULT 1 COMMENT 'Node level',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp'
)
    AUTO_INCREMENT = 1
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;


CREATE TABLE IF NOT EXISTS `test_case` (
    `id`                     varchar(50) NOT NULL COMMENT 'Test case ID',
    `node_id`                int(13) NOT NULL COMMENT 'Node ID this case belongs to',
    `node_path`              varchar(50) NOT NULL COMMENT 'Node path this case belongs to',
    `project_id`             varchar(50) NOT NULL COMMENT 'Project ID this test belongs to',
    `name`                   varchar(64) NOT NULL COMMENT 'Case name',
    `type`                   varchar(25) NOT NULL COMMENT 'Test case type',
    `maintainer`             varchar(25) NOT NULL COMMENT 'Test case maintainer',
    `priority`               varchar(50) NOT NULL COMMENT 'Test case priority',
    `method`                 varchar(15) NOT NULL COMMENT 'Test case method type',
    `prerequisite`           varchar(255) DEFAULT NULL COMMENT 'Test case prerequisite condition',
    `remark`                 text DEFAULT NULL COMMENT 'Test case remark',
    `steps`                  text DEFAULT NULL COMMENT 'Test case steps (JSON format)',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp',
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;


CREATE TABLE IF NOT EXISTS `test_plan_test_case` (
    `id`                     int(13) PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    `plan_id`                varchar(50) NOT NULL COMMENT 'Plan ID relation to',
    `case_id`                varchar(50) NOT NULL COMMENT 'Case ID relation to',
    `executor`               varchar(64) NOT NULL COMMENT 'Test case executor',
    `status`                 varchar(15) NULL COMMENT 'Test case status',
    `results`                longtext COMMENT 'Test case result',
    `remark`                 varchar(255) DEFAULT NULL COMMENT 'Test case remark',
    `create_time`            bigint(13)  NOT NULL COMMENT 'Create timestamp',
    `update_time`            bigint(13)  NOT NULL COMMENT 'Update timestamp'
)
    AUTO_INCREMENT = 1
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_bin;

-- track end
