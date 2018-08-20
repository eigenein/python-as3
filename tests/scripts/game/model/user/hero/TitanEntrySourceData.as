package game.model.user.hero
{
   public class TitanEntrySourceData
   {
       
      
      public var id:int;
      
      public var star:int;
      
      public var color:int;
      
      public var power:int;
      
      protected var _level:int;
      
      public function TitanEntrySourceData(param1:Object = null)
      {
         super();
         if(param1)
         {
            id = param1.id;
            star = param1.star;
            color = param1.color;
            power = param1.power;
            parseLevel(param1);
         }
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      protected function parseLevel(param1:Object) : void
      {
         if(param1.lvl)
         {
            level = param1.lvl;
         }
         else if(param1.level)
         {
            level = param1.level;
         }
      }
   }
}
