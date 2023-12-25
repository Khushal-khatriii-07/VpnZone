import 'dart:convert';
import 'dart:math';

class VpnInfo{
  late final String hostName;
  late final String ip;
  late final int ping;
  late final int speed;
  late final String countryLongName;
  late final String countryShortName;
  late final int vpnSessionNum;
  late final String base64OpenVpnConfigurationData;

  VpnInfo({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLongName,
    required this.countryShortName,
    required this.vpnSessionNum,
    required this.base64OpenVpnConfigurationData
  });

  VpnInfo.fromJson(Map<String, dynamic> jsonData){
    hostName = jsonData['HostName'] ?? '0';
    ip = jsonData['IP'] ?? '0';
    ping = jsonData['Ping'] ?? 0 ;
    speed = jsonData['Speed'] ?? 0;
    countryLongName = jsonData['CountryLong'] ?? '0';
    countryShortName = jsonData['CountryShort'] ?? '0';
    vpnSessionNum = jsonData['NumVpnSessions'] ?? 0;
    base64OpenVpnConfigurationData = jsonData['OpenVPN_ConfigData_Base64'] ?? '0';
  }

  Map<String, dynamic> toJson(){
    final jsonData = <String, dynamic>{};
    jsonData['HostName'] = hostName;
    jsonData['IP'] = ip;
    jsonData['Ping'] = ping;
    jsonData['Speed'] = speed;
    jsonData['CountryLong'] = countryLongName;
    jsonData['CountryShort'] = countryShortName;
    jsonData['NumVpnSessions'] = vpnSessionNum;
    jsonData['OpenVPN_ConfigData_Base64'] = base64OpenVpnConfigurationData;
    return jsonData;
  }
}