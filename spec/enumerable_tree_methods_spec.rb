
describe "EnumerableTreeMethods" do
  # Tree:
  #   a
  #     b
  #       c
  #     d
  #
  let(:d) { [:d, []] }
  let(:c) { [:c, []] }
  let(:b) { [:b, [c]] }
  let(:a) { [:a, [b, d]] }

  def keys(a) = a.map(&:first) 

  describe "Enumerable#preorder" do
    it "returns tree nodes in preorder" do
      expect(a.preorder { |e| e.last }).to eq [a, b, c, d]
    end
    context "with a false argument" do
      it "excludes self" do
        expect(a.preorder(false) { |e| e.last }).to eq [b, c, d]
      end
    end
  end

  describe "Enumerable#postorder" do
    it "returns tree nodes in postorder" do
      expect(a.postorder { |e| e.last }).to eq [c, b, d, a]
    end
    context "with a false argument" do
      it "excludes self" do
        expect(a.postorder(false) { |e| e.last }).to eq [c, b, d]
      end
    end
  end
end

