import AmberBase

public class AmberFoundation
{
    static public func register()
    {
        AmberBase.register(StringPersistenceStrategy())
    }
}