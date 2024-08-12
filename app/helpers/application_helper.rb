module ApplicationHelper
  def btn_class
    'inline-block rounded border border-brown-600 bg-brown-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-brown-600 focus:outline-none focus:ring active:text-brown-500'
  end

  def btn_class_small
    'inline-block rounded border border-brown-600 bg-brown-600 px-1 py-1 text-xs font-medium text-white hover:bg-transparent hover:text-brown-600 focus:outline-none focus:ring active:text-brown-500'
  end

  def format_date(date)
    date.strftime('%F')
  end
end