package game.view.gui.components.tooltip
{
   public class TitleAndDescriptionValueObject
   {
       
      
      private var _title:String;
      
      private var _description:String;
      
      public function TitleAndDescriptionValueObject(param1:String, param2:String)
      {
         super();
         this._title = param1;
         this._description = param2;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get description() : String
      {
         return _description;
      }
   }
}
