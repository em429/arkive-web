import { query, run } from '$lib/db'

export async function post({ params, request }) {
  let form = await request.formData()
  let url = await form.get('url')

  let hide_page = run('UPDATE webpage SET hidden = 1 WHERE url = ?', [url])

  if (hide_page) {
    return {
      status: 303,
      headers: {
        location: '/',
      },
    }
  }

  return {
    status: 404,
  }
}
