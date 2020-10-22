class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    @@all << self
  end

  def self.all 
    @@all 
  end

  def new_meal(customer, total, tip = 0)
    Meal.new(self, customer, total, tip)
  end

  def meals
    Meal.all.select {|meal| meal.waiter == self}
  end

  def best_tipper
    best_tipped_meal = meals.max {|meal_a, meal_b| meal_a.tip <=> meal_b.tip}
    best_tipped_meal.customer
  end

  def freq_customer
    freq = meals.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    meals.max_by { |customer| freq[customer] }.customer
  end

  def meal_of_worst_tip
    worst_meal_tip = meals.max {|meal_a, meal_b| meal_b.tip <=> meal_a.tip}
    worst_meal_tip
  end
  
end