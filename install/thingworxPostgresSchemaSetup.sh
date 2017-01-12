#! /bin/bash
server="localhost"
database="thingworx"
port=5432
username="twadmin"
schema="public"
option="all"

while [ "$1" != "" ]; do
	case $1 in
		-h | -H )	shift
					server=$1
					;;
		-p | -P )	shift
					port=$1
					;;
		-d | -D )	shift
					database=$1
					;;
		-s | -S )	shift
					schema=$1
					;;
		-o | -O )	shift
					option=$1
					;;
		-u | -U )	shift
					username=$1
					;;
		--help )	shift
					echo "usage: thingworxPostgresSchemaSetup.sh [-h <server>] [-p <port>] [-d <thingworx-database-name>] [-s <schema-name>] [-u <thingworx-database-username>] [-o <option (all,model,data,property,modelwithproperty)>]"
					exit 1
					;;
		* )
					echo Unknown Option $1
					exit 1
					;;
	esac
	shift
done

echo Server=$server
echo Port=$port
echo Database=$database
echo Schema=$schema
echo Option=$option
echo User=$username

echo Start Execution

if [ "$option" = "all" ]; then
psql -q -h $server -U $username -d $database -p $port -v user_name=$username -v searchPath=$schema<< EOF
\i ./thingworx-model-schema.sql
\i ./thingworx-property-schema.sql
\i ./thingworx-data-schema.sql
EOF
fi

if [ "$option" = "model" ]; then
psql -q -h $server -U $username -d $database -p $port -v user_name=$username -v searchPath=$schema<< EOF
\i ./thingworx-model-schema.sql
EOF
fi

if [ "$option" = "property" ]; then
psql -q -h $server -U $username -d $database -p $port -v user_name=$username -v searchPath=$schema<< EOF
\i ./thingworx-property-schema.sql
EOF
fi

if [ "$option" = "data" ]; then
psql -q -h $server -U $username -d $database -p $port -v user_name=$username -v searchPath=$schema<< EOF
\i ./thingworx-data-schema.sql
EOF
fi

if [ "$option" = "modelwithproperty" ]; then
psql -q -h $server -U $username -d $database -p $port -v user_name=$username -v searchPath=$schema<< EOF
\i ./thingworx-model-schema.sql
\i ./thingworx-property-schema.sql
EOF
fi

echo End Execution
