package game.battle.view.text
{
   import game.assets.FontAsset;
   import starling.text.BitmapFont;
   
   public class BattleFloatingTextStyle
   {
       
      
      public var color:uint;
      
      public var size:int;
      
      public var font:BitmapFont;
      
      public var duration:Number;
      
      public var movement:Number;
      
      public var layerToFindFreeSpot:int;
      
      public function BattleFloatingTextStyle(param1:int, param2:uint, param3:FontAsset, param4:Number = 1.25, param5:Number = 90, param6:int = 0)
      {
         super();
         this.size = param1;
         this.color = param2;
         this.font = param3.font;
         this.duration = param4;
         this.movement = param5;
         this.layerToFindFreeSpot = param6;
      }
   }
}
