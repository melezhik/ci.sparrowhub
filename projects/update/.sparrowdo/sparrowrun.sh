set -e
# deployment type: default
# activate sparrowdo shipped rakudo
eval $(/opt/sparrowdo/rakudo/rakudo-moar-2024.06-01-linux-x86_64-gcc/scripts/set-env.sh --quiet 2>/dev/null)
# add binaries installed via zef install --to=home
export PATH=~/.raku/bin/:$PATH
cd .sparrowdo/
export SP6_REPO=https://sparrowhub.io/repo
export SP6_PREFIX=.sparrowdo/update
export SP6_TAGS='SCM_URL=https://github.com/melezhik/ci.sparrowhub.git SCM_SHA=HEAD
,SCM_SHA=d0bfc028,SCM_URL=https://github.com/melezhik/ci.sparrowhub.git,SCM_BRANCH=HEAD,SPARKY_PROJECT=update,SPARKY_JOB_ID=lfyebmdzqsrtjkioanvu2685289,SPARKY_WORKER=localhost,SPARKY_TCP_PORT=4000,SPARKY_API_TOKEN=rakuandsparky1983'
export SP6_FORMAT_COLOR=1
raku -MSparrow6::Task::Repository -e Sparrow6::Task::Repository::Api.new.index-update
raku -MSparrow6::DSL sparrowfile
