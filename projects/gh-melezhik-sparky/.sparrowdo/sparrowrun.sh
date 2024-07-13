set -e
# deployment type: docker
# activate sparrowdo shipped rakudo
eval $(/opt/sparrowdo/rakudo/rakudo-moar-2024.06-01-linux-x86_64-gcc/scripts/set-env.sh --quiet 2>/dev/null)
# add binaries installed via zef install --to=home
export PATH=~/.raku/bin/:$PATH
cd /var/.sparrowdo/env/gh-melezhik-sparky/.sparrowdo
export SP6_REPO=https://sparrowhub.io/repo
export SP6_PREFIX=.sparrowdo/gh-melezhik-sparky
export SP6_TAGS='SCM_URL=https://github.com/melezhik/sparky.git,owner=melezhik,SCM_SHA=d83ec94f,SCM_URL=https://github.com/melezhik/sparky.git,SCM_BRANCH=HEAD,SPARKY_PROJECT=gh-melezhik-sparky,SPARKY_JOB_ID=ijrsoueagckndzyhtlxw2640213,SPARKY_WORKER=docker,SPARKY_TCP_PORT=4000,SPARKY_API_TOKEN=rakuandsparky1983'
export SP6_FORMAT_COLOR=1
raku -MSparrow6::Task::Repository -e Sparrow6::Task::Repository::Api.new.index-update
raku -MSparrow6::DSL sparrowfile
