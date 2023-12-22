describe "ObjectTreeMethods" do
  describe "Object#follow" do
    klass = Class.new do
      attr_reader :name
      attr_reader :parent
      def initialize(parent, name) @name, @parent = name, parent end
    end

    let(:a) { klass.new(nil, "a") }
    let(:b) { klass.new(a, "b") }
    let(:c) { klass.new(b, "c") }
    let(:d) { klass.new(a, "d") }

    it "follows a chain of nodes" do
      expect(c.follow(&:parent)).to eq [b, a]
    end
    it "returns the empty array if no followers" do
      expect(a.follow(&:parent)).to eq []
    end
    context "with a true argument" do
      it "includes self" do
        expect(c.follow(true, &:parent)).to eq [c, b, a]
      end
      it "returns self if no followers" do
        expect(a.follow(true, &:parent)).to eq [a]
      end
    end
  end
end


