# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "salt/map.jinja" import salt_settings with context %}

{%- if grains['os']|lower not in ['fedora'] %}
salt-pkgrepo-install-saltstack-redhat:
  pkgrepo.managed:
    - name: {{ salt_settings.pkgrepo_name }}
    - humanname: {{ salt_settings.pkgrepo_humanname }}
    - baseurl: {{ salt_settings.pkgrepo }}
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: {{ salt_settings.key_url }}
    {% if salt_settings.pkgrepo_extra_settings is defined -%}
    {% for pkgrepo_setting, pkgrepo_setting_value in salt_settings.pkgrepo_extra_settings.items() -%}
    - {{ pkgrepo_setting }}: {{ pkgrepo_setting_value }}
    {% endfor %}
    {% endif -%}
    {%- if grains['os']|lower in ['amazon'] %}
    - failovermethod: priority
    - priority: 10
    {%- endif %}
{%- endif %}
