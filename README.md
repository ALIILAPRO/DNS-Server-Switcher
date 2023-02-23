#DNS Server Switcher

This script allows you to easily set your DNS server on Linux using NetworkManager.

## Usage

1. Clone the repository:

    ```
    git clone https://github.com/ALIILAPRO/DNS-Server-Switcher.git
    ```

2. Navigate to the project directory:

    ```
    cd DNS-Server-Switcher
    ```

3. Run the script:

    ```
    sudo bash dns_switcher.sh
    ```

4. Select an action from the menu:

    ```
    [1] Set DNS servers
    [2] Clear DNS servers
    ```

## Supported DNS Servers

By default, the script comes with a list of popular DNS servers in Iran. You can modify this list by editing the `DNS_SERVERS` array in the script.

| DNS Server   | IP Addresses          |
| ------------ | ---------------------|
| Shecan DNS   | 178.22.122.100,185.51.200.2 |
| Begzar DNS   | 185.55.225.25,185.55.226.26 |
| 403 DNS      | 10.202.10.202,10.202.10.102 |
| Radar DNS    | 10.202.10.10,10.202.10.11 |

## Requirements

This script requires the following:

- NetworkManager: This is usually pre-installed on most Linux distributions.

## Script Details

- `dns_server_setter.sh`: This is the main script file.
- `display_dns_servers()`: This function displays the list of supported DNS servers.
- `validate_input()`: This function validates user input.
- `set_dns_servers()`: This function sets the DNS servers.
- `clear_dns_servers()`: This function clears the DNS servers.

## Improvements

The following improvements can be made to the script:

- Add a check to ensure that the script is being run with administrative privileges.
- Add support for more operating systems.

## Supported Operating Systems

- Ubuntu
- Debian
- CentOS

## License

This script is licensed under the GPL-3.0 license. See the [LICENSE](https://github.com/ALIILAPRO/DNS-Server-Switcher/blob/master/LICENSE) file for more details.
