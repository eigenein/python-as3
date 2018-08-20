package engine.context.platform.social.posting
{
   public class ActionType
   {
      
      public static const OBTAIN:ActionType = new ActionType("obtain");
      
      public static const EVOLVE:ActionType = new ActionType("evolve");
      
      public static const PROMOTE:ActionType = new ActionType("promote");
      
      public static const GAIN:ActionType = new ActionType("gain");
      
      public static const HOLD:ActionType = new ActionType("hold");
      
      private static var _map:Array = [];
      
      {
         _map[OBTAIN._type] = OBTAIN;
         _map[EVOLVE._type] = OBTAIN;
         _map[PROMOTE._type] = OBTAIN;
         _map[GAIN._type] = OBTAIN;
         _map[HOLD._type] = OBTAIN;
      }
      
      private var _type:String;
      
      public function ActionType(param1:String)
      {
         super();
         _type = param1;
      }
      
      public static function getItem(param1:String) : ActionType
      {
         return _map[param1];
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
