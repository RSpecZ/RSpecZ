RSpec.describe RSpecZ do
  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with(:name) {'Mike'}.desc('feawfeawfeawer').so do
          it { expect(name).to eq('Mike') }
        end
        with(:name) {'Mike'}.desc('feawfeawfeawer') do
          it { expect(name).to eq('Mike') }
        end
      end
    }.to raise_error(RuntimeError, 'You have some .with method without .so method. You may miss .so method in your code.')
  end

  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with(:name) {'Mike'}.desc('feawfeawfeawer').so do
          it { expect(name).to eq('Mike') }
        end
        with(:name) {'Mike'}.desc('feawfeawfeawer').so do
          it { expect(name).to eq('Mike') }
        end
      end
    }.not_to raise_error
  end

  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with_nil(:name).so do
          it {expect(name).to be_nil }
        end
        with_nil(:name) do
          it {expect(name).to be_nil }
        end
      end
    }.to raise_error(RuntimeError, 'You have some .with method without .so method. You may miss .so method in your code.')
  end

  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with_nil(:name).so do
          it {expect(name).to be_nil }
        end
        with_nil(:name).so do
          it { expect(name).to be_nil }
        end
      end
    }.not_to raise_error
  end

  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with(:name) { 'feafe' }.so do
          with(:aaa, 'lalal').so do
            with(:bbb, 'feafea').so do
              it { expect(name).to eq('feafe') }
            end
          end
        end
        with_nil(:name).so do
          it { expect(name).to eq(nil) }
        end
      end
    }.not_to raise_error
  end

  it do
    expect {
      RSpecZ.describe 'Test for RSpecZ' do
        with(:name) { 'feafe' }.so do
          with(:aaa, 'lalal').so do
            with(:bbb, 'feafea') do # need so here
              it { expect(name).to eq('feafe') }
            end
          end
        end
        with_nil(:name).so do
          it { expect(name).to eq(nil) }
        end
      end
    }.to raise_error(RuntimeError, 'You have some .with method without .so method. You may miss .so method in your code.')
  end
end
