# What it this?

A simple set of files that does only one thing: reliably reproduce my Consul setup in a Rancher distributed environment. I run Docker instances on many geographically remote servers and use Rancher for central management as well as Consul to monitor these nodes.

**Rancher** is awesome become it provides this distributed container lifecycle management that others, such as the Docker folks themselves, seem to be having a hard time to put together.

**Consul** is awesome because it is, to my knowledge, the only lightweight monitoring tool that relies on a consensus protocol (here: Raft) to weed out false positives (negatives?)

**Ansible** is not as awesome as I wish it was but it sure helps ensure configuration consistency without the need for additional agents.

# How do I use this?

**Step #1:** you can use my version of voxxit's super lightweight Consul container -- it relies on Alpine Linux which, you guessed it, is awesome. Or you can use the provided Dockerfile to adapt it to your own needs. If you go with the latter, you will need a Docker Hub account to allow remote Docker setups to see your image:

    HA=<your_hub_account>
    docker build -t $HA/consul .
    docker login --username=$HA --email=<your_hub_email>
    docker tag <your_image_hash> $HA/consul:latest
    docker push $HA/consul
    
**Step #2:** Edit your Ansible host file so that your consul hosts will be properly listed. It is important for the bootstrap server to be the first one in the host list. So, provided you stick with my choice to call said group 'rancher' your list will look something like:

    [rancher]
    <hostname> ansible_host=<ip address>
    <hostname> ansible_host=<ip address>
    <hostname> ansible_host=<ip address>
    ...

If you decided to create your own image, you will need to edit `consul_docker_compose.j2` to reflect that. Be very careful as Jinja-in-Ansible does not handle indentation of `{%` statements well. Like, at all.

**Step #3:** Update `setup_consul.yml` to use your own work directory. You may also remove the `rancher-compose up` statement and run in manually if you are interested in the bootstrapping process' output.

Run ansible:

    ansible-playbook setup_consul.yml
    
Using Rancher's console, admire the whole process as it comes to life.

OK, I think this README file may now contain more text than the configuration files themselves. Simplicity!

# Who are you?

Chris Ravenscroft. I do various things and tend to forget to document them.

-- https://nexus.zteo.com