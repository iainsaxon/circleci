<?php

class Nsm_better_meta_new_upd
{
    var $version = '1.0';

    public function install()
    {
        $data = array(
            'module_name' => 'Nsm_better_meta_new',
            'module_version' => $this->version,
            'has_cp_backend' => 'y',
            'has_publish_fields' => 'y'
        );

        ee()->db->insert('modules', $data);

        return true;

    }

    public function update($current = false)
    {
    }

    public function uninstall()
    {
    }
}
