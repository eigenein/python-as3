package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.data.storage.hero.UnitDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.inventory.HeroDescriptionClip;
   
   public class HeroPopupStatListInfoBlock extends HeroDescriptionClip
   {
       
      
      public var tf_desc:ClipLabel;
      
      public var tf_label_stats:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var line1:ClipSprite;
      
      public var line2:ClipSprite;
      
      public function HeroPopupStatListInfoBlock()
      {
         tf_desc = new ClipLabel();
         tf_label_stats = new ClipLabel();
         tf_name = new ClipLabel();
         line1 = new ClipSprite();
         line2 = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_desc.maxHeight = Infinity;
      }
      
      override protected function createLayout() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [tf_name,tf_desc,line1,tf_line,tf_roleExtended,tf_main_stat,line2,tf_label_stats];
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            layout_main.addChild(_loc2_[_loc3_].graphics);
            _loc3_++;
         }
      }
      
      override public function setData(param1:UnitDescription) : void
      {
         super.setData(param1);
         tf_name.text = param1.name;
         tf_desc.text = param1.descText;
      }
   }
}
