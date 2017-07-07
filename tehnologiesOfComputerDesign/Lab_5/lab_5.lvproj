<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="10008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="4SUM (SubVI).vi" Type="VI" URL="../../Sequential_Logic/4SUM (SubVI).vi"/>
		<Item Name="4SUM.vi" Type="VI" URL="../4SUM.vi"/>
		<Item Name="COMPLCPMP.vi" Type="VI" URL="../COMPLCPMP.vi"/>
		<Item Name="SMPLCOMP.vi" Type="VI" URL="../SMPLCOMP.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="SUM_1 (SubVI).vi" Type="VI" URL="../../Sequential_Logic/SUM_1 (SubVI).vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
