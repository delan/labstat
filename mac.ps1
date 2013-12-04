# You may need to run the following once interactively for your user account:
# Set-ExecutionPolicy Bypass -Scope CurrentUser

$o = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$H = '{0}.{1}' -f $o.HostName, $o.DomainName

$o = Get-Date
$D = "{0:yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'}" -f $o.ToUniversalTime()

$o = gwmi -Class Win32_NetworkAdapterConfiguration -Filter `
	'DHCPEnabled = TRUE' | Where-Object { `
	-not ($_.Description -match 'VMware') -and `
	-not ($_.Description -match 'VirtualBox') }
$m = $o.MACAddress
$a = $o.IPAddress

# Similarly to how $o is only an array if there are multiple NICs, $o.MACAddress
# and $o.IPAddress are arrays only if there are multiple MAC or IP addresses,
# respectively. If they aren't, we'll normalise this by boxing them.

If ($m.GetType().Name -eq 'String') {
	$m = @($m)
}

If ($a.GetType().Name -eq 'String') {
	$a = @($a)
}

$M = $m[0]
$A = '0.0.0.0'
$S = 'Link'

Foreach ($addr in $o.IPAddress) {
	# Is the address IPv4?
	If ($addr -match '\.') {
		$A = $addr
	}
	# Is the address IPv6?
	If ($addr -match ':') {
		# Is the address outside fe80::/16?
		If (-not ($addr -match '^fe80')) {
			$S = 'Global'
		}
	}
}

$o = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { `
	$_.AdapterType -match 'Ethernet' -and `
	-not ($_.Name -match 'VMware') -and `
	-not ($_.Name -match 'VirtualBox') }
$L = $o.Speed / 1000000

$out = "| {0} | {1} | {2} | {3} | {4} | {5} |" -f $H, $D, $M, $A, $S, $L

Add-Content -Path 'mac.ps1.out.txt' -Value $out

# Eject the drive.

$drive = $pwd.Drive.Name + ':\'
$sa = New-Object -comObject Shell.Application
$sa.Namespace($drive).Self.InvokeVerb("eject")

# Finally, log out.

Logoff
