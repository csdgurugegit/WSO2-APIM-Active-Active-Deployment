FROM mysql
USER root

RUN mkdir -p /home/entrypointscript
RUN mkdir -p /home/sqlvolume
RUN mkdir -p /home/dbscripts
RUN mkdir -p /home/cnf
RUN chmod 777 -R /home/entrypointscript
RUN chmod 777 -R /home/sqlvolume
RUN chmod 777 -R /home/dbscripts
RUN chmod 777 -R /home/cnf

COPY sql/req_run.sql /home/dbscripts/
COPY sql/apim_db.sql /home/dbscripts/
COPY sql/shared_db.sql /home/dbscripts/
COPY cnf/root.cnf /home/cnf/
COPY cnf/apimadmin.cnf /home/cnf/
COPY cnf/sharedadmin.cnf /home/cnf/
COPY entrypoint.sh /home/entrypointscript/
COPY runscript.sh /docker-entrypoint-initdb.d/

RUN chmod +x /home/entrypointscript/entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/runscript.sh
RUN chmod +x /home/dbscripts/req_run.sql
RUN chmod +x /home/dbscripts/apim_db.sql
RUN chmod +x /home/dbscripts/shared_db.sql
RUN chmod +x /home/cnf/root.cnf
RUN chmod +x /home/cnf/apimadmin.cnf
RUN chmod +x /home/cnf/sharedadmin.cnf

ENTRYPOINT ["/home/entrypointscript/entrypoint.sh"]
EXPOSE 3306 33060
CMD ["mysqld"]



