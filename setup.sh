# Installing Go
# Reference: https://go.dev/doc/install
wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
rm go1.21.1.linux-amd64.tar.gz
GOPATH=/usr/local/go/bin
GOPROFILE=/etc/profile.d/go.sh
# export PATH=$PATH:$GOPATH
echo "export PATH=\$PATH:$GOPATH" | tee -a ~/.bashrc
source ~/.bashrc
sudo touch $GOPROFILE; sudo chmod a+x $GOPROFILE;
echo "export PATH=\$PATH:$GOPATH" | sudo tee -a $GOPROFILE

# Install Docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $1

# Install kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install kubebuilder
# download kubebuilder and install locally.
curl -L -o kubebuilder "https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH)"
chmod +x kubebuilder && sudo mv kubebuilder /usr/local/bin/

# Add auto completion
sudo apt install bash-completion
# kubebuilder autocompletion
echo "source <(kubebuilder completion bash)" | tee -a ~/.bashrc
source ~/.bashrc

#######################################################################################################

# Create Project
go mod init github.com/Welasco/secretstoazkeyvault.git
# The folder must be empty to execute this command
kubebuilder init --domain vwslab.com --owner welasco