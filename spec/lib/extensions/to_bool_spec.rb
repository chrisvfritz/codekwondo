describe Extensions::ToBool do

  describe '#to_bool' do

    it 'should return false when "no"' do
      expect( 'no'.to_bool ).to eq(false)
    end

    it 'should return false when "false"' do
      expect( 'false'.to_bool ).to eq(false)
    end

    it 'should return false when false' do
      expect( false.to_bool ).to eq(false)
    end

    it 'should return false when "0"' do
      expect( '0'.to_bool ).to eq(false)
    end

    it 'should return false when 0' do
      expect( 0.to_bool ).to eq(false)
    end

    it 'should return true when "yes"' do
      expect( 'yes'.to_bool ).to eq(true)
    end

    it 'should return true when "true"' do
      expect( 'true'.to_bool ).to eq(true)
    end

    it 'should return true when true' do
      expect( true.to_bool ).to eq(true)
    end

    it 'should return true when "1"' do
      expect( '1'.to_bool ).to eq(true)
    end

    it 'should return true when 1' do
      expect( 1.to_bool ).to eq(true)
    end

    it 'should return false when nil' do
      expect( nil.to_bool ).to eq(false)
    end

  end

  describe '#is_bool?' do

    it 'should return true when "no"' do
      expect( 'no'.is_bool? ).to eq(true)
    end

    it 'should return true when "false"' do
      expect( 'false'.is_bool? ).to eq(true)
    end

    it 'should return true when false' do
      expect( false.is_bool? ).to eq(true)
    end

    it 'should return true when "0"' do
       expect( '0'.is_bool? ).to eq(true)
    end

    it 'should return true when 0' do
       expect( 0.is_bool? ).to eq(true)
    end

    it 'should return true when "yes"' do
       expect( 'yes'.is_bool? ).to eq(true)
    end

    it 'should return true when "true"' do
       expect( 'true'.is_bool? ).to eq(true)
    end

    it 'should return true when true' do
       expect( true.is_bool? ).to eq(true)
    end

    it 'should return true when "1"' do
       expect( '1'.is_bool? ).to eq(true)
    end

    it 'should return true when 1' do
       expect( 1.is_bool? ).to eq(true)
    end

    it 'should return false when nil' do
       expect( nil.is_bool? ).to eq(false)
    end

  end

end