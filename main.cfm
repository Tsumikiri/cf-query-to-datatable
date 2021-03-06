<cfscript>
	function QueryToDataTable(query, labels="", roles="", dform="", nform="", tform="") {
		var typeMap = { "CHAR": "string", "VARCHAR": "string", "BINARY": "string", "VARBINARY": "string", "BLOB": "string", "TEXT": "string", "ENUM": "string", "SET": "string", "INTEGER": "number", "": "number", "SMALLINT": "number", "TINYINT": "number", "MEDIUMINT": "number", "BIGINT": "number", "DECIMAL": "number", "NUMERIC": "number", "FLOAT": "number", "DOUBLE": "number", "BIT": "number", "YEAR": "number", "TIMESTAMP": "datetime", "DATETIME": "datetime", "DATE": "date", "TIME": "timeofday", "": "string" };
		var data = { "cols": [], "rows": [] };
		for (i = 1; i lte query.columnList.listLen(); i++) {
			var col = {};
			col["id"] = query.getMetaData().getColumnName(i);
			if (labels neq "" and i lte labels.listLen(",", true)) {
				col["label"] = labels.listGetAt(i, ",", true);
			}
			var type = query.getMetaData().getColumnTypeName(i);
			col["type"] = typeMap[typeMap.keyExists(type) ? type : ""];
			if (roles neq "" and i lte roles.listLen(",", true)) {
				var role = roles.listGetAt(i, ",", true);
				if (role neq "") {
					col["role"] = role;
				}
			}
			data["cols"].append(col);
		}
		for (record in query) {
			var row = { "c": [] };
			for (i = 1; i lte query.columnList.listLen(); i++) {
				var column = data["cols"][i]["id"];
				var type = data["cols"][i]["type"];
				var value = record[column];
				if (nform neq "" and type eq "number") {
					cell = { "v": value };
					if (nform neq "") {
						if (Right(nform, 1) eq "%") {
							cell["f"] = NumberFormat(100 * value, Left(nform, Len(nform) - 1)) & "%";
						} else {
							cell["f"] = NumberFormat(value, nform);
						}
					}
				} else if (type eq "datetime") {
					cell = { "v": "Date(" & value.year() & ", " & value.month() - 1 & ", " & value.dateTimeFormat("d, H, n, s") & ")" };
					if (dform neq "") {
						cell["f"] = value.dateTimeFormat(dform);
					}
				} else if (type eq "date") {
					cell = { "v": "Date(" & value.year() & ", " & value.month() - 1 & ", " & value.day() & ")" };
					if (dform neq "") {
						cell["f"] = value.dateFormat(dform);
					}
				} else if (type eq "timeofday") {
					cell = { "v": [ value.hour(), value.minute(), value.second() ] };
					if (tform neq "") {
						cell["f"] = value.timeFormat(tform);
					}
				} else if (value neq "") {
					cell = { "v": value };
				} else {
					cell = { "v": JavaCast("null", "") };
				}
				row["c"].append(cell);
			}
			data["rows"].append(row);
		}
		return data;
	}
</cfscript>
