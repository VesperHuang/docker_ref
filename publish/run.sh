#./run.sh common
# $1 : project_name

cd ./$1
tar cvzf ../$1.tgz *
cd ..
rm -rf ./app/
mkdir ./app
mv $1.tgz ./app/
rm -rf ./$1

#publish
tar cvf publish.zip --exclude=*.sh --exclude=*.zip --strip-components=1 *
mv ./publish.zip ~/Downloads
scp -i ~/.ssh/id_rsa_vesper ~/Downloads/publish.zip vesper@192.168.0.1:~
