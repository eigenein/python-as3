package game.view.specialoffer.multibundle
{
   import game.view.gui.components.controller.TouchHoverContoller;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   
   public class CyberMondayTripleSkinCoinMatrixFall
   {
       
      
      private var hover:TouchHoverContoller;
      
      private var grid:Vector.<Vector.<MatrixFallItem>>;
      
      public const container:Sprite = new Sprite();
      
      public function CyberMondayTripleSkinCoinMatrixFall(param1:DisplayObjectContainer)
      {
         var _loc5_:int = 0;
         var _loc2_:* = undefined;
         var _loc6_:int = 0;
         super();
         grid = new Vector.<Vector.<MatrixFallItem>>();
         var _loc3_:int = 14;
         var _loc4_:int = 20;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            var _loc7_:* = new Vector.<MatrixFallItem>();
            grid[_loc5_] = _loc7_;
            _loc2_ = _loc7_;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc2_[_loc6_] = new MatrixFallItem(this,_loc5_,_loc6_);
               _loc6_++;
            }
            _loc5_++;
         }
         hover = new TouchHoverContoller(param1);
         param1.addEventListener("enterFrame",onEnterFrame);
      }
      
      public function setWord(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            setChar(param2 + _loc4_,param3,param1.charAt(_loc4_));
            _loc4_++;
         }
      }
      
      public function onEnterFrame() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = grid.length;
         var _loc3_:int = grid[0].length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = grid[_loc4_];
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc1_[_loc5_].update();
               _loc5_++;
            }
            _loc4_++;
         }
         if(hover.hover && Math.random() < 0.04 * _loc2_)
         {
            _loc6_ = 10 + 10 * Math.random();
            powerUp(Math.random() * _loc2_,0,_loc6_,2 + Math.random() * 5);
         }
      }
      
      function powerUp(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(param1 >= 0 && param1 < grid.length)
         {
            if(param2 >= 0 && param2 < grid[param1].length)
            {
               grid[param1][param2].powerUp(param3,Math.random() * Math.random() * 3,param4);
            }
         }
      }
      
      protected function setChar(param1:int, param2:int, param3:String) : void
      {
         if(param1 >= 0 && param1 < grid.length)
         {
            if(param2 >= 0 && param2 < grid[param1].length)
            {
               grid[param1][param2].setChar(param3);
            }
         }
      }
   }
}
