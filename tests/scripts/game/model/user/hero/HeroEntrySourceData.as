package game.model.user.hero
{
   public class HeroEntrySourceData
   {
       
      
      public var id:int;
      
      public var star:int;
      
      public var color:int;
      
      public var slots:Object;
      
      public var power:int;
      
      protected var _level:int;
      
      public function HeroEntrySourceData(param1:Object = null)
      {
         super();
         if(param1)
         {
            id = param1.id;
            star = param1.star;
            slots = param1.slots;
            color = param1.color;
            parseLevel(param1);
            power = param1.power;
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
