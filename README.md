# Vorgehen
Als erstes habe ich den Code aus dem Auftrag übernommen und im main.tf gespeichert. Anschliessend habe ich mit dem Code auseinandergesetzt und mir angeschaut, was genau was macht.
Anschliessend habe ich versucht meine Umgebung mit Ansible aufzufahren. Eigentlich war es nicht so schwer. Da ich in den Ferien den Ansible Auftrag nochmals mit meinem Vater (er arbeitet beruflich viel mit Ansible) gemacht habe, konnte ich einige globale Variablen ersetzten und es funktionierte (mein Vater hat mir viel von Ansible gezeigt, auch Dinge, die nicht zu diesem Auftrag gehört haben). Also noch nicht so ganz. Denn es gab noch einige Probleme. Auf der VM konnte ich nicht einfach Pakete wie beispielsweise MariaDB installieren. Das lag daran, dass noch eine Einstellung im sources.list File nicht richtig war. Das konnte dann mit dem Folgenden Ansible Modul behoben werden.

- name: Install mariadb and pip
  ansible.builtin.apt:
    pkg:
    - mariadb-server
    - python3-pip
    update_cache: yes

Dort habe ich einfach noch die Zeile update_cache erstellt.

Anschliessend gab es nur noch kleine Fehler und Flüchtigkeitsfehler. (vergessen die richtige Public IP einzutragen usw.) Hier war der grosse Zeitfresser einfach herauszufinden wie ich das nun Umsetze.
Der Gedanke, dass ich eigentlich nur die Public IP beim Ansible Auftrag am richtigen Ort eintragen muss, um alles im AWS heraufzufahren, kam mir übrigens mitten in der Woche um Mitternacht als ich schon längst hätte schlafen sollen. :^)


# Reflexion
Der Auftrag hat mir anfangs eher weniger Spass gemacht. Und ich spreche hier vorallem von Ansible. Ich fand den Auftrag mühsam und anstrengen. Die Motivation gross Zeit hineinzustecken war nicht vorhanden. Hat jemand im Betrieb, oder mein Vater Ansible erwähnt, war meine Reaktion immer nur "ahhhh nöd scho wieder de scheiss". Doch mein Vater hat sich in den Ferien, oder von mir aus auch in der unterichtsfreien Zeit, die Zeit genommen und mir den Auftrag erklärt und auch einiges über den Auftrag hinaus zu Ansible gezeigt. Ich habe den Nutzen von Anisble verstanden und der Auftrag hat mir richtig viel Spass gemacht. Die letzten drei Wochen sind beinahe 20 Stunden in Ansible und Terraform eingeflossen und ich finde überhaupt nicht, dass es verschwendete Zeit war. 