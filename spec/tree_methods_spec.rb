describe TreeMethods do
  it 'has a version number' do
    expect(TreeMethods::VERSION).not_to be_nil
  end

  # Tree:
  #   a
  #     b
  #       c
  #     d
  
  # Array implementation 
  let!(:ad) { [:ad, []] }
  let!(:ac) { [:ac, []] }
  let!(:ab) { [:ab, [ac]] }
  let!(:aa) { [:aa, [ab, ad]] }

  let(:children) { lambda { |e| e.last } }

  # Struct implementation
  klass = Class.new do
    attr_reader :name
    attr_reader :parent
    attr_reader :children
    def initialize(parent, name) 
      @name, @parent = name, parent 
      @children = []
      parent&.attach(self)
    end
    def attach(node) @children << node end
    def inspect = name.inspect.to_sym
  end

  let!(:sa) { klass.new(nil, "sa") }
  let!(:sb) { klass.new(sa, "sb") }
  let!(:sc) { klass.new(sb, "sc") }
  let!(:sd) { klass.new(sa, "sd") }

  describe "Object#follow" do
    it "follows a chain of nodes" do
      expect(sc.follow(&:parent)).to eq [sb, sa]
    end
    it "returns the empty array if no followers" do
      expect(sa.follow(&:parent)).to eq []
    end
    context "with a true argument" do
      it "includes self" do
        expect(sc.follow(true, &:parent)).to eq [sc, sb, sa]
      end
      it "returns self if no followers" do
        expect(sa.follow(true, &:parent)).to eq [sa]
      end
    end
  end

  describe "Object#preorder" do
    it "returns tree nodes in preorder" do
      expect(aa.preorder(&children)).to eq [aa, ab, ac, ad]
      expect(sa.preorder(&:children)).to eq [sa, sb, sc, sd]
    end
    context "with a false argument" do
      it "excludes self" do
        expect(aa.preorder(false, &children)).to eq [ab, ac, ad]
        expect(sa.preorder(false, &:children)).to eq [sb, sc, sd]
      end
    end
  end

  describe "Object#postorder" do
    it "returns tree nodes in postorder" do
      expect(aa.postorder(&children)).to eq [ac, ab, ad, aa]
      expect(sa.postorder(&:children)).to eq [sc, sb, sd, sa]
    end
    context "with a false argument" do
      it "excludes self" do
        expect(aa.postorder(false, &children)).to eq [ac, ab, ad]
        expect(sa.postorder(false, &:children)).to eq [sc, sb, sd]
      end
    end
  end
end


