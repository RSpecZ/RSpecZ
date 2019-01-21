RSpec.describe RSpecZ do
  it { expect(RSpecZ::VERSION).to eq "0.1.1" }

  set_valid(:bool, true) do
    it { expect(bool).to be_truthy }
  end

  set_invalid(:bool, false) do
    it { expect(bool).to be_falsy }
  end

  set_invalids(:num, 2, 4, 6, 12) do
    it { expect(num).not_to be_odd }
  end
end
