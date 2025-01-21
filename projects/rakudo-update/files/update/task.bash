set -e

version=$(config version)
arch=$(config arch)

set -x

cd ~/projects/SparrowCI

echo "build melezhik/sparrow:${arch}_arm rakudo version: ${version}"
docker build Dockerfiles/ -f Dockerfiles/sparrow.$arch.arm \
--build-arg rakudo_version=$version \
-t melezhik/sparrow:${arch}_arm_${version}

echo "push melezhik/sparrow:${arch}_arm"
docker push melezhik/sparrow:${arch}_arm_${version}

echo "delete intermediate docker data"
docker system prune -f
