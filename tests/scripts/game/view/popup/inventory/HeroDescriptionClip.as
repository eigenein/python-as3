package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroDescriptionClip extends GuiClipNestedContainer
   {
       
      
      public var tf_line:ClipLabel;
      
      public var tf_roleExtended:SpecialClipLabel;
      
      public var tf_main_stat:SpecialClipLabel;
      
      public var layout_main:ClipLayout;
      
      public function HeroDescriptionClip()
      {
         tf_line = new ClipLabel();
         tf_roleExtended = new SpecialClipLabel();
         tf_main_stat = new SpecialClipLabel();
         layout_main = ClipLayout.vertical(5);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_roleExtended.maxHeight = Infinity;
         tf_main_stat.maxHeight = Infinity;
         tf_line.maxHeight = Infinity;
         layout_main.height = NaN;
         createLayout();
      }
      
      public function setData(param1:UnitDescription) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = undefined;
         var _loc5_:HeroDescription = param1 as HeroDescription;
         var _loc3_:String = ColorUtils.hexToRGBFormat(14020423);
         if(_loc5_)
         {
            tf_line.text = _loc5_.role.localizedPrimaryRoleDesc;
            _loc2_ = Translate.translate("LIB_BATTLESTATDATA_" + _loc5_.mainStat.name.toUpperCase());
            tf_main_stat.text = Translate.translateArgs("UI_DIALOG_HERO_MAIN_STAT",_loc3_ + _loc2_);
            _loc6_ = _loc5_.role.localizedExtendedRoleList;
            if(_loc6_.length == 1)
            {
               _loc4_ = Translate.translateArgs("UI_DIALOG_HERO_ROLE_SINGLE",_loc3_ + _loc6_.join(", "));
            }
            else
            {
               _loc4_ = Translate.translateArgs("UI_DIALOG_HERO_ROLE_LIST",_loc3_ + _loc6_.join(", "));
            }
            tf_roleExtended.text = _loc4_;
         }
         else
         {
            tf_line.text = "";
            tf_main_stat.text = "";
            tf_roleExtended.text = "";
         }
      }
      
      protected function createLayout() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [tf_line,tf_roleExtended,tf_main_stat];
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            layout_main.addChild(_loc2_[_loc3_].graphics);
            _loc3_++;
         }
      }
   }
}
