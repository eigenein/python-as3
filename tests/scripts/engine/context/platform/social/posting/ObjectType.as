package engine.context.platform.social.posting
{
   public class ObjectType
   {
      
      public static const HERO:ObjectType = new ObjectType("hero");
      
      public static const TITAN:ObjectType = new ObjectType("titan");
      
      public static const ARENA_RANK:ObjectType = new ObjectType("arena_rank");
      
      private static var _map:Array = [];
      
      {
         _map[HERO._type] = HERO;
         _map[ARENA_RANK._type] = ARENA_RANK;
      }
      
      private var _type:String;
      
      public function ObjectType(param1:String)
      {
         super();
         _type = param1;
      }
      
      public static function getItem(param1:String) : ObjectType
      {
         return _map[param1];
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
