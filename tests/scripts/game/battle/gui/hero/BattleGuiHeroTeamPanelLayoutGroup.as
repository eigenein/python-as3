package game.battle.gui.hero
{
   import feathers.core.FeathersControl;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipLayout;
   
   public class BattleGuiHeroTeamPanelLayoutGroup extends ClipLayout
   {
       
      
      private var entries:Vector.<HeroTeamPanelSortEntry>;
      
      private var panelsInvalidated:Boolean = false;
      
      public function BattleGuiHeroTeamPanelLayoutGroup(param1:String)
      {
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.horizontalAlign = param1;
         _loc2_.gap = 1;
         super(_loc2_);
         entries = new Vector.<HeroTeamPanelSortEntry>();
      }
      
      public function addHeroPanel(param1:FeathersControl, param2:FeathersControl, param3:Number) : void
      {
         panelsInvalidated = true;
         var _loc4_:HeroTeamPanelSortEntry = new HeroTeamPanelSortEntry();
         _loc4_.background = param1;
         _loc4_.foreground = param2;
         _loc4_.sortIndex = param3;
         entries.push(_loc4_);
      }
      
      override protected function validateChildren() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(panelsInvalidated)
         {
            panelsInvalidated = false;
            resortChildren();
         }
         super.validateChildren();
         var _loc2_:int = entries.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = entries[_loc3_];
            _loc1_.background.x = _loc1_.foreground.x;
            _loc1_.background.y = _loc1_.foreground.y;
            _loc3_++;
         }
      }
      
      protected function resortChildren() : void
      {
         var _loc2_:int = 0;
         entries.sort(sort_panelsBySortIndex);
         var _loc1_:int = entries.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            addChildAt(entries[_loc2_].background,_loc2_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            addChildAt(entries[_loc2_].foreground,_loc2_ + _loc1_);
            _loc2_++;
         }
      }
      
      private function sort_panelsBySortIndex(param1:HeroTeamPanelSortEntry, param2:HeroTeamPanelSortEntry) : int
      {
         return param2.sortIndex - param1.sortIndex;
      }
   }
}

import starling.display.DisplayObject;

class HeroTeamPanelSortEntry
{
    
   
   public var background:DisplayObject;
   
   public var foreground:DisplayObject;
   
   public var sortIndex:Number;
   
   function HeroTeamPanelSortEntry()
   {
      super();
   }
}
