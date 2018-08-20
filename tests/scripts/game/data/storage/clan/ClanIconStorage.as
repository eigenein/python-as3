package game.data.storage.clan
{
   public class ClanIconStorage
   {
       
      
      public const colorIds:Vector.<int> = new Vector.<int>();
      
      public const flagShapeIds:Vector.<int> = new Vector.<int>();
      
      public const iconShapeIds:Vector.<int> = new Vector.<int>();
      
      public function ClanIconStorage()
      {
         super();
      }
      
      public function get randomColor() : int
      {
         var _loc1_:int = Math.random() * colorIds.length;
         return colorIds[_loc1_];
      }
      
      public function get randomPattern() : int
      {
         var _loc1_:int = Math.random() * flagShapeIds.length;
         return flagShapeIds[_loc1_];
      }
      
      public function get randomIcon() : int
      {
         var _loc1_:int = Math.random() * iconShapeIds.length;
         return iconShapeIds[_loc1_];
      }
      
      public function initialize(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_.type == "flagShape")
            {
               flagShapeIds.push(_loc2_.value);
            }
            else if(_loc2_.type == "iconColor")
            {
               colorIds.push(_loc2_.value);
            }
            else if(_loc2_.type == "iconShape")
            {
               iconShapeIds.push(_loc2_.value);
            }
         }
      }
   }
}
