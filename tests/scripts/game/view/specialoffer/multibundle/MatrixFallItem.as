package game.view.specialoffer.multibundle
{
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.SpecialBitmapFontTextFormat;
   
   public class MatrixFallItem
   {
       
      
      private var root:CyberMondayTripleSkinCoinMatrixFall;
      
      private var label:GameLabel;
      
      private var sprite:GuiAnimation;
      
      private var spreadTimer:int = -1;
      
      private var maxSpreadTimer:int = -1;
      
      private var power:int;
      
      private var maxPower:int;
      
      private var speed:int;
      
      private var x:int;
      
      private var y:int;
      
      private var hiddenChar:String;
      
      protected var num:int = 0;
      
      public function MatrixFallItem(param1:CyberMondayTripleSkinCoinMatrixFall, param2:int, param3:int)
      {
         sprite = new GuiAnimation();
         super();
         this.root = param1;
         this.x = param2;
         this.y = param3;
         label = new SpecialClipLabel(false,false,true);
         label.textRendererProperties.textFormat = new SpecialBitmapFontTextFormat(AssetStorage.font.Officina16,16,16759552,"left");
         label.x = param2 * 20;
         label.y = param3 * 20;
         param1.container.addChild(label);
      }
      
      public function update() : void
      {
         if(power <= 0)
         {
            return;
         }
         if(spreadTimer > 0)
         {
            spreadTimer = Number(spreadTimer) - 1;
            if(spreadTimer == 0)
            {
               root.powerUp(x,y + 1,maxPower,maxSpreadTimer);
               if(speed < 2)
               {
                  setup(false,maxPower > 12?0.5:0.25);
               }
            }
         }
         power = Number(power) - 1;
         if(power == 0)
         {
            label.text = "";
            return;
         }
         if(speed == 1 && Math.random() < 0.05)
         {
            setup(true,NaN);
         }
         if(speed == 2 && power % 2 == 0)
         {
            setup(true,NaN);
         }
      }
      
      public function setChar(param1:String) : void
      {
         this.hiddenChar = param1;
      }
      
      public function powerUp(param1:int, param2:int, param3:int) : void
      {
         setup(true,1);
         this.maxSpreadTimer = param3;
         this.spreadTimer = param3;
         this.maxPower = param1;
         this.power = param1;
         this.speed = param2;
         if(param2 == 2 && Math.random() < 0.3)
         {
            param1 = param1 * 3;
         }
      }
      
      protected function setup(param1:Boolean, param2:Number) : void
      {
         var _loc3_:* = null;
         if(param1)
         {
            if(hiddenChar != null && (speed < 2 || Math.random() < 0.5))
            {
               label.text = hiddenChar;
            }
            else
            {
               _loc3_ = "QWERTYUIOPASDFGHJKLZXCVBNM//{}|:L<>?!@#$%^&*()1234567890`~";
               label.text = _loc3_.charAt(int(Math.random() * _loc3_.length));
            }
         }
         if(param2 == param2)
         {
            label.alpha = param2;
         }
      }
   }
}
