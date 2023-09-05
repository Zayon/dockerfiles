# Ansible

Docker image for [Ansible](https://docs.ansible.com/)

## Playbook usage

`playbooks` directory is expected to be mounted at `/app` inside the container.

Make sure that files used in playbooks are mounted as well.

```sh
docker run -it --rm \
    -e SSH_AUTH_SOCK='/tmp/agent.sock' \
    -v "${HOME}/.ssh/known_hosts/:/root/.ssh/known_hosts:ro" \
    -v "${SSH_AUTH_SOCK}:/tmp/agent.sock" \
    -v "$(pwd):/app" \
    zayon/ansible:latest \
        ansible-playbook \
        -i "$ip," \
        -e "ansible_ssh_user=$username" \
        playbooks/test-playbook.yaml
```

## Vault usage

```sh
docker run -it --rm \
    -v "$(pwd):/app" \
    zayon/ansible:latest \
        ansible-vault create my-secrets.yaml
```

---

[Back to home](https://github.com/Zayon/dockerfiles)

