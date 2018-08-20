package game.view.popup.inventory
{
   import feathers.layout.VerticalLayout;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.hero.watch.InventoryItemInfoTooltipDataFactory;
   import game.view.gui.components.ClipLabel;
   
   public class HeroDescriptionInventoryClip extends HeroDescriptionClip
   {
       
      
      public var tf_fragment_count:ClipLabel;
      
      public function HeroDescriptionInventoryClip()
      {
         super();
      }
      
      override public function setData(param1:UnitDescription) : void
      {
         tf_fragment_count.text = InventoryItemInfoTooltipDataFactory.getHeroFragmentDesc(param1);
         super.setData(param1);
      }
      
      override protected function createLayout() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [tf_fragment_count,tf_line,tf_roleExtended,tf_main_stat];
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            layout_main.addChild(_loc2_[_loc3_].graphics);
            _loc3_++;
         }
         (layout_main.layout as VerticalLayout).gap = 15;
      }
   }
}
