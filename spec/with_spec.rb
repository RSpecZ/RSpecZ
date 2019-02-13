RSpec.describe RSpecZ do
  with(:name) { 'Mike' }.desc('feawfeawfeawer').so do
    it { expect(name).to eq('Mike') }
  end

  with { @name = 'mike' }.so do
    it { expect(@name).to eq('mike') }
  end

  with(:name, 'test', 'jajaja').so do |value|
    it { expect(name).to eq(value) }
  end

  with(:name, 4565465).so do
    it { expect(name).to eq(4565465) }
  end

  with_valid(:name, 'feawfee').so do
    it { expect(name).to eq('feawfee') }
  end
  with_invalid(:name, 'feawfee').so do
    it { expect(name).to eq('feawfee') }
  end
  with_missing(:name, 'feawfee').so do
    it { expect(name).to eq('feawfee') }
  end
  with_valid(:name, 'feawfee', 'jajaja').so { |value| it { expect(name).to eq(value) } }
  with_invalid(:name, 'feawfee', 'jajaja').so { |value| it { expect(name).to eq(value) } }
  with_missing(:name, 'feawfee', 'jajaja').so { |value| it { expect(name).to eq(value) } }

  with(:name, 'test-name').and(:address) { 'test-address' }.so { it {
    expect(name).to eq('test-name')
    expect(address).to eq('test-address')
  } }
  with(:name, 'test-name').and(:address) do
    'test-address'
  end.so { it {
    expect(name).to eq('test-name')
    expect(address).to eq('test-address')
  } }

  with(:name) { 'test-name' }.and(:address) { 'test-address' }.so { it {
    expect(name).to eq('test-name')
    expect(address).to eq('test-address')
  } }

  with_nils(:name).so { it { expect(name).to be_nil } }

  let(:inherit_let) { 'test' }
  with(:inherit_let) { _super + 'test' }.so { it { expect(inherit_let).to eq('testtest') } }

  with(:name) { { aa: 'test' } }.so { it { expect(name[:aa]).to eq('test') } }
  with(:name) { { aa: { bb: 'test' }, test: { a: { b: 'test' } } } }.so { it { expect(name[:aa][:bb]).to eq('test') } }

  # with(:name, 'feakefa', 'afeaw').desc('feafe').so do
  #   it { expect(1).to eq(1) }
  # end
  # => this will occur error

  context do
    make(:test) { p 'test1' }
    with(:test) { p 'test2' }.so { it { expect(0).to eq(0) } }
  end
end
