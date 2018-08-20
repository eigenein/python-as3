package game.battle.gui.hero
{
   import battle.data.BattleHeroDescription;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import flash.utils.Dictionary;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import starling.display.DisplayObject;
   
   public class BattleGUIHeroListLayoutGroup extends LayoutGroup
   {
       
      
      private var teamSize:int = 0;
      
      private var unusedHeroButtonsCount:int = 0;
      
      private var panelByHero:Dictionary;
      
      private var heroButtons:Vector.<BattleHeroPanel>;
      
      private var panelsInvalidated:Boolean = false;
      
      private var _sortDirection:int = 1;
      
      public function BattleGUIHeroListLayoutGroup()
      {
         panelByHero = new Dictionary();
         heroButtons = new Vector.<BattleHeroPanel>();
         super();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 15;
         layout = _loc1_;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = heroButtons.length;
         _loc2_ = teamSize;
         while(_loc2_ < _loc1_)
         {
            heroButtons[_loc2_].dispose();
            _loc2_++;
         }
         super.dispose();
         teamSize = 0;
         heroButtons.length = 0;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function attachHeroPanel(param1:BattleHeroControllerWithPanel) : void
      {
         var _loc4_:* = null;
         panelsInvalidated = true;
         var _loc2_:BattleHeroDescription = param1.hero.desc;
         if(panelByHero[_loc2_])
         {
            panelByHero[_loc2_].data = param1;
            return;
         }
         var _loc3_:int = heroButtons.length;
         if(teamSize < _loc3_)
         {
            _loc4_ = heroButtons[teamSize];
         }
         else
         {
            _loc4_ = new BattleHeroPanel();
            heroButtons[teamSize] = _loc4_;
         }
         teamSize = Number(teamSize) + 1;
         addChildAt(_loc4_.backGraphics,0);
         addChild(_loc4_.frontGraphics);
         panelByHero[_loc2_] = _loc4_;
         _loc4_.data = param1;
      }
      
      public function addCustomManualActionEvent(param1:CustomManualActionEvent) : void
      {
         var _loc2_:BattleHeroPanel = panelByHero[param1.hero];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.addCustomManualAction(param1.action);
      }
      
      override protected function validateChildren() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(panelsInvalidated)
         {
            panelsInvalidated = false;
            removeUnusedPanels();
            sortChildren(sort_byHeroOrder);
         }
         super.validateChildren();
         var _loc1_:int = heroButtons.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = heroButtons[_loc2_];
            _loc3_.backGraphics.x = _loc3_.frontGraphics.x;
            _loc3_.backGraphics.y = _loc3_.frontGraphics.y;
            _loc2_++;
         }
      }
      
      private function removeUnusedPanels() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = heroButtons.length;
         _loc2_ = teamSize;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = heroButtons[_loc2_];
            removeChild(_loc3_.backGraphics);
            removeChild(_loc3_.frontGraphics);
            _loc2_++;
         }
      }
      
      private function sort_byHeroOrder(param1:DisplayObject, param2:DisplayObject) : Number
      {
         var _loc6_:* = NaN;
         _loc6_ = 10000000;
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < teamSize)
         {
            _loc7_ = heroButtons[_loc5_];
            if(_loc7_.backGraphics == param1)
            {
               _loc4_ = Number(_loc7_.battleOrder + 10000000);
            }
            else if(_loc7_.frontGraphics == param1)
            {
               _loc4_ = Number(_loc7_.battleOrder);
            }
            else if(_loc7_.backGraphics == param2)
            {
               _loc3_ = Number(_loc7_.battleOrder + 10000000);
            }
            else if(_loc7_.frontGraphics == param2)
            {
               _loc3_ = Number(_loc7_.battleOrder);
            }
            _loc5_++;
         }
         return (_loc3_ - _loc4_) * _sortDirection;
      }
   }
}
