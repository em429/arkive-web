import { query, run } from '$lib/db'

let url

export async function get({ request }) {
  let archived_pages = query(
    'SELECT timestamp, url, internet_archive_url, archive_today_url, original_title, to_freeze_dry, freezedry_path, read FROM webpage WHERE hidden = 0',
    []
  )

  if (archived_pages) {
    return {
      body: { archived_pages },
    }
  }

  return {
    status: 404,
  }
}

export async function post({ request }) {
  let form = await request.formData()
  let url = await form.get('url')
  let unread_only = await form.get('unread_only')

  search_string = '%' + url + '%'

  let archived_pages = query(
    'SELECT timestamp, url, internet_archive_url, archive_today_url, original_title, to_freeze_dry, freezedry_path, read FROM webpage WHERE url LIKE ? AND hidden = 0',
    [search_string]
  )

  if (unread_only === 'on') {
    console.log(unread_only)

    archived_pages = query(
      'SELECT timestamp, url, internet_archive_url, archive_today_url, original_title, to_freeze_dry, freezedry_path, read FROM webpage WHERE url LIKE ? AND read = 0 AND hidden = 0',
      [search_string]
    )
  }

  if (archived_pages) {
    return {
      body: { archived_pages },
    }
  }

  return {
    status: 404,
  }
}
