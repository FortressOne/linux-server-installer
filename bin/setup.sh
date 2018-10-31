#!/usr/bin/env bash

error() {
    echo
    printf "%s\n" "$*"
    exit 1
}

[ "$(which unzip)" ] || error "ERROR: The package 'unzip' is not installed. Please install it and run the installation again."
[ "$(which wget)" ] || error "ERROR: The package 'wget' is not installed. Please install it and run the installation again."

TARGET="$HOME/bin/fortressonesv"

printf "Choose installation directory [%s]: " "$TARGET"
read -r INSTALL_DIR

if [ ! -z "$INSTALL_DIR" ]; then
  TARGET=$INSTALL_DIR
fi

if [ -d "$TARGET" ]; then
  error "ERROR: Target directory already exists."
fi

echo "Installing to $TARGET"

mkdir -p "$TARGET"

# Check directory succesfully created
if [ ! -d "$TARGET" ]; then
  error "ERROR: Target directory failed to create."
fi

printf "Enter server name: "
read -r HOSTNAME

printf "Enter server admin information: "
read -r SV_ADMININFO

printf "Enter remote console password: "
read -r RCON_PASSWORD

printf "Enter admin password: "
read -r ADMINPWD

echo "Downloading MVDSV 0.32"
wget -nv --show-progress https://s3-ap-southeast-2.amazonaws.com/qwtf/mvdsv.zip

echo "Downloading Quake shareware pak file"
mkdir id1/
wget -nv --show-progress https://s3-ap-southeast-2.amazonaws.com/qwtf/paks/id1/pak0.pak -P id1/

echo "Downloading FortressOne pak file"
mkdir fortress/
wget -nv --show-progress https://s3-ap-southeast-2.amazonaws.com/qwtf/paks/fortress/pak0.pak -P fortress/

echo "Downloading FortressOne Server qwprogs.dat"
wget -nv --show-progress https://github.com/FortressOne/server-qwprogs/releases/download/v0.1.0/qwprogs.dat

echo "Downloading FortressOne Server default configs"
wget -nv --show-progress https://github.com/FortressOne/server-configs/archive/master.zip

echo "Installing MVDSV 0.32"
unzip -qq mvdsv.zip -d "$TARGET"

echo "Installing Quake shareware pak file"
cp -r id1/ "$TARGET"

echo "Installing FortressOne pak file"
mkdir -p "$TARGET/fortress/"
cp -r fortress/ "$TARGET"

echo "Installing FortressOne Server qwprogs.dat"
cp qwprogs.dat "$TARGET/fortress"

echo "Installing FortressOne Server default configs"
unzip -qq master.zip
sed -i "s|HOSTNAME|$HOSTNAME|g" server-configs-master/fortress/config.cfg
sed -i "s|SV_ADMININFO|$SV_ADMININFO|g" server-configs-master/fortress/config.cfg
sed -i "s|RCON_PASSWORD|$RCON_PASSWORD|g" server-configs-master/fortress/config.cfg
sed -i "s|ADMINPWD|$ADMINPWD|g" server-configs-master/fortress/config.cfg
cp -r server-configs-master/* "$TARGET"

echo "FortressOne Server installed successfully"
