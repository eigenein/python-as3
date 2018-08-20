package game.battle.gui.teambuffs
{
   import starling.core.Starling;
   import starling.display.Sprite;
   
   public class BattleTeamEffectBar
   {
      
      private static var POSITION_UPDATE_RATE:Number = 0.3;
      
      private static var ITEM_X_GAP:Number = 10;
      
      private static var ITEM_WIDTH:Number = 40;
      
      private static var PADDING_X:Number = 20;
       
      
      private var icons:Vector.<BattleTeamEffectIcon>;
      
      private var attackersDirection:Boolean;
      
      private var width:Number;
      
      public const graphics:Sprite = new Sprite();
      
      public function BattleTeamEffectBar(param1:Boolean)
      {
         var _loc2_:* = null;
         icons = new Vector.<BattleTeamEffectIcon>();
         super();
         this.attackersDirection = param1;
         setSize(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
      }
      
      public function dispose() : void
      {
      }
      
      public function add(param1:BattleTeamEffectIcon) : void
      {
         icons.push(param1);
         graphics.addChild(param1.graphics);
         updatePosition(param1,icons.length - 1,icons.length,1);
      }
      
      public function cleanUpBattle() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = icons.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            icons[_loc1_].disable();
            _loc1_++;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = icons.length;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            var _loc6_:* = icons[_loc4_];
            icons[_loc4_ - _loc2_] = _loc6_;
            _loc3_ = _loc6_;
            _loc3_.advanceTime(param1);
            updatePosition(_loc3_,_loc4_,_loc5_,POSITION_UPDATE_RATE);
            if(_loc3_.isDisposed)
            {
               _loc2_++;
            }
            _loc4_++;
         }
         if(_loc2_ > 0)
         {
            icons.length = _loc5_ - _loc2_;
         }
      }
      
      protected function updatePosition(param1:BattleTeamEffectIcon, param2:int, param3:int, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:* = 1;
         if(attackersDirection)
         {
            _loc5_ = PADDING_X + param2 * (ITEM_WIDTH * _loc6_ + ITEM_X_GAP);
         }
         else
         {
            _loc5_ = -PADDING_X - ITEM_WIDTH - param2 * (ITEM_WIDTH * _loc6_ + ITEM_X_GAP);
         }
         param1.graphics.x = param1.graphics.x * (1 - param4) + param4 * _loc5_;
      }
      
      protected function setSize(param1:int, param2:int) : void
      {
         graphics.y = 80;
         this.width = param1 * 0.5;
         if(attackersDirection)
         {
            graphics.x = 0;
         }
         else
         {
            graphics.x = param1;
         }
      }
   }
}
