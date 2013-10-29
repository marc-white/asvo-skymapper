require 'spec_helper'

describe SearchController do

  it 'search fields are in order' do
    ctrl = SearchController.new
    fields = ctrl.search_fields('fs')
    fields.should == [
        { name: 'Object Id', field: 'global_object_id' },
        { name: 'Right ascension', field: 'mean_ra' },
        { name: 'Declination', field: 'mean_dcl' },
        { name: 'u', field: 'flux_u' },
        { name: 'v', field: 'flux_v' },
        { name: 'g', field: 'flux_g' },
        { name: 'r', field: 'flux_r' },
        { name: 'i', field: 'flux_i' },
        { name: 'z', field: 'flux_z' }
    ]

    fields = ctrl.search_fields('ms')
    fields.should == [
        { name: 'Object Id', field: 'new_object_id' },
        { name: 'Right ascension', field: 'ra' },
        { name: 'Declination', field: 'dcl' },
        { name: 'u', field: 'mean_u' },
        { name: 'v', field: 'mean_v' },
        { name: 'g', field: 'mean_g' },
        { name: 'r', field: 'mean_r' },
        { name: 'i', field: 'mean_i' },
        { name: 'z', field: 'mean_z' }
    ]
  end

  it 'search fields are in order' do
    ctrl = SearchController.new
    fields = ctrl.image_search_fields('image')
    fields.should == [
        { name: 'Right ascension', field: 'POINTRA_DEG' },
        { name: 'Declination', field: 'POINTDEC_DEG' },
        { name: 'Filter', field: 'FILTER' },
        { name: 'Survey', field: 'IMAGE_TYPE' },
        { name: 'Observation Date (UTC)', field: 'DATE' }
    ]
  end

end