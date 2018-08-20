package game.battle.view.text
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import starling.text.TextField;
   
   public class BattleFloatingText extends TextField
   {
       
      
      public var style:BattleFloatingTextStyle;
      
      public var movement:Number;
      
      public var yMovement:Number;
      
      public var phase:Number;
      
      public var crossLine:ClipSprite;
      
      public function BattleFloatingText(param1:Number, param2:Number, param3:String, param4:BattleFloatingTextStyle, param5:Number, param6:Number)
      {
         super(300,30,param3,param4.font.name,param4.size,16777215,true);
         phase = 0;
         this.alpha = 1;
         this.style = param4;
         this.movement = param5;
         this.yMovement = param6;
         this.batchable = true;
         this.x = param1 - width * 0.5;
         this.y = param2;
      }
      
      public function init(param1:Number, param2:Number, param3:String, param4:BattleFloatingTextStyle, param5:Number, param6:Number) : void
      {
         phase = 0;
         this.alpha = 1;
         this.style = param4;
         this.fontSize = param4.size;
         this.fontName = param4.font.name;
         this.movement = param5;
         this.yMovement = param6;
         this.text = param3;
         this.x = param1 - width * 0.5;
         this.y = param2;
      }
      
      public function addCrossLine() : void
      {
         if(crossLine == null)
         {
            crossLine = AssetStorage.rsx.battle_interface.create(ClipSprite,"energy_cross_line");
            crossLine.graphics.x = width * 0.5 - crossLine.graphics.width * 0.5 - 1;
            crossLine.graphics.y = 6;
         }
         addChild(crossLine.graphics);
      }
   }
}
