##
#
# SELECTOR ARRAY
#
#######

GLOBAL_MODULE_MAIN_SELECTOR=(
    "angavel:selector:project-control"
    "angavel:selector:docker"
    "angavel:selector:docker-composition"
    "angavel:selector:backups"
    "angavel:selector:git"
    "ws:change-environment"
    "ws:change-module"
)

GLOBAL_MODULE_PROJECT_CONTROL_SELECTOR=(
    "angavel:project:start"
    "angavel:project:stop"
    "angavel:selector:project-start"
    
    "angavel:selector:main"
)
GLOBAL_MODULE_PROJECT_START_SELECTOR=(
    "angavel:project:start-fresh"
    "angavel:project:start-refresh"
    "angavel:project:start"
    
    "angavel:selector:project-control"
    "angavel:selector:main"
)
GLOBAL_MODULE_DOCKER_SELECTOR=(
    "angavel:selector:main"
)
GLOBAL_MODULE_DOCKER_COMPOSITION_SELECTOR=(
    "angavel:selector:main"
)
GLOBAL_MODULE_BACKUPS_SELECTOR=(
    "angavel:selector:main"
)
GLOBAL_MODULE_COMPOSITION_SELECTOR=(
    "angavel:selector:main"
)
GLOBAL_MODULE_GIT_SELECTOR=(
    "angavel:selector:main"
)
