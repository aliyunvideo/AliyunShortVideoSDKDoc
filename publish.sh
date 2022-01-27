
cp -rf ../../other/ShortVideoDoc/*  ./

version=$1

echo $version

 git add .
 git commit -m "release $version"
 git push

 git tag  $version
 git push --tags
