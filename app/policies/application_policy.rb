# Базовый класс для всех политик с набором типичных CRUDL действий
# По умолчанию все действия, кроме show? запрещены
class ApplicationPolicy
  attr_reader :record, :context, :pin, :user

  delegate :user, to: :context
  delegate :pin, to: :context

  # По умолчанию Pundit в качестве первого аргумента подставляет current_user, если политика вызывается в контроллере
  def initialize(context, record)
    @context = context
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Вложенный базовый класс Scope
  # Его дочерние классы используется при вызове policy_scope(some_scope)
  # для конкретной политики, а в качестве аргумента передается исходный скоуп,
  # например Events.all
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
