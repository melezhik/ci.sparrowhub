set -e

version=$(config version)
arch=$(config arch)
basedir=$(config basedir)

cd $basedir

echo "build melezhik/sparrow:${arch}_arm rakudo version: ${version}"
docker build Dockerfiles/ -f Dockerfiles/sparrow.$arch.arm \
--build-arg rakudo_version=$version \
-t melezhik/sparrow:${arch}_arm_${version} \
--progress plain

echo "push melezhik/sparrow:${arch}_arm"
docker push melezhik/sparrow:${arch}_arm_${version}

echo  "docker image tag melezhik/sparrow:${arch}_arm_${version} melezhik/sparrow:${arch}_arm"
docker image tag melezhik/sparrow:${arch}_arm_${version} melezhik/sparrow:${arch}_arm

echo "delete intermediate docker data"

docker system prune -f
