# ansible-sd-cuda

Preps Ubuntu Server LTS for CUDA with Stable Diffusion

## Usage

Ensure you're using a relatively recent version of Python (required for ansible) locally and then run the provided playbook against your target machine.

```zsh
# Install ansible and requirements
python -m pip install --upgrade pip poetry
poetry install
# Now run the playbook
poetry run python -m ansible playbook \
    -i 192.168.1.10,  \
    -u myremoteusername --key-file ~/.ssh/mysecretkey.id_rsa --ask-become-pass \
    ansible/cuda.yaml
```

## Testing

Launch a multipass VM for testing against.

```zsh
➜ make multipass-start

Name                    State             IPv4             Image
cuda-test               Running           192.168.64.3     Ubuntu 22.04 LTS
```

Now grab the IP address

```zsh
➜ multipass info cuda-test | grep IPv4 | awk -F': *' '{print $2}'

192.168.64.3
```

And run an example ansible command.

```zsh
poetry run python -m ansible adhoc all \
    -i 192.168.64.3,  \
    -u ansible --key-file multipass/ansible.id_rsa \
    --ssh-common-args="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
    -m ping
```

Now run the provided playbook against the host.

```zsh
poetry run python -m ansible playbook \
    -i 192.168.64.3,  \
    -u ansible --key-file multipass/ansible.id_rsa \
    --ssh-common-args="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
    ansible/cuda.yaml
```
