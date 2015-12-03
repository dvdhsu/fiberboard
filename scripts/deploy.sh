ssh deployer@fiberboard_api.notifsta.com << HERE
cd /srv/fiberboard
git pull
scripts/restart_prod
HERE
